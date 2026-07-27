// Emails a contact-form submission to the support inbox.
//
// Called by the `contact_request_notify` trigger on `contact_requests`, which
// fires `net.http_post` after the row is committed. The row is the record of
// truth: this function only tells a human it exists. If it fails, the message
// is still in the table — which is what the GDPR runbook reads.
//
// JWT verification is off (the caller is Postgres, not a signed-in user), so
// the endpoint authenticates on a shared secret instead. Without it, anyone
// knowing the URL could make the app email us.

const RESEND_ENDPOINT = "https://api.resend.com/emails";

interface ContactRequest {
  id: string;
  created_at: string;
  name: string;
  email: string;
  category: string;
  message: string;
  user_id: string | null;
}

function escapeHtml(value: string): string {
  return value
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;");
}

function body(row: ContactRequest): string {
  // The submitter controls every one of these fields, so they are escaped
  // before landing in an HTML mail.
  const line = (label: string, value: string) =>
    `<p style="margin:0 0 4px"><strong>${label}</strong> ${escapeHtml(value)}</p>`;
  return [
    line("From", `${row.name} <${row.email}>`),
    line("Category", row.category),
    line("Sent", row.created_at),
    line("Account", row.user_id ?? "not signed in"),
    `<hr style="border:none;border-top:1px solid #ddd;margin:16px 0">`,
    `<pre style="white-space:pre-wrap;font-family:inherit;margin:0">${
      escapeHtml(row.message)
    }</pre>`,
    `<hr style="border:none;border-top:1px solid #ddd;margin:16px 0">`,
    `<p style="color:#888;font-size:12px;margin:0">contact_requests · ${row.id}</p>`,
  ].join("");
}

Deno.serve(async (req: Request): Promise<Response> => {
  const hookSecret = Deno.env.get("CONTACT_HOOK_SECRET");
  const resendKey = Deno.env.get("RESEND_API_KEY");
  const to = Deno.env.get("CONTACT_INBOX") ?? "admin@aevon.studio";
  // Both defaults must stay on the verified domain: Resend only delivers mail
  // from resend.dev to the account owner, so a test sender would silently
  // narrow who can be notified.
  const from = Deno.env.get("CONTACT_FROM") ?? "contact@aevon.studio";

  if (!hookSecret || !resendKey) {
    console.error("missing CONTACT_HOOK_SECRET or RESEND_API_KEY");
    return new Response("not configured", { status: 500 });
  }
  if (req.headers.get("x-hook-secret") !== hookSecret) {
    return new Response("forbidden", { status: 403 });
  }

  let row: ContactRequest;
  try {
    row = (await req.json()).record as ContactRequest;
    if (!row?.id) throw new Error("no record in payload");
  } catch (e) {
    console.error("bad payload", e);
    return new Response("bad request", { status: 400 });
  }

  const res = await fetch(RESEND_ENDPOINT, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${resendKey}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      from: `Repster <${from}>`,
      to: [to],
      // Replying to the notification answers the user directly.
      reply_to: row.email,
      subject: `[Repster · ${row.category}] ${row.name}`,
      html: body(row),
    }),
  });

  if (!res.ok) {
    const detail = await res.text();
    console.error("resend rejected the mail", res.status, detail);
    return new Response("send failed", { status: 502 });
  }

  console.log("notified", row.id);
  return new Response("ok", { status: 200 });
});
