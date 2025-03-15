import type { Metadata } from "next";
import "./globals.css";
import { Montserrat } from 'next/font/google'
import { Analytics } from "@vercel/analytics/react"
import { ThemeProvider } from "@/components/theme-provider";

const montserrat = Montserrat({
    weight: ['400', '500', '600', '700'],
    style: ['normal'],
    subsets: ["latin-ext"],
    display: 'swap',
    variable: '--font-montserrat',
});

export const metadata: Metadata = {
    title: "Repster",
    description: "Manage your workouts and track your progress",
};

export default function RootLayout({
    children,
}: Readonly<{
    children: React.ReactNode;
}>) {
    return (
        <html lang="fr" suppressHydrationWarning>
            <body
                className={`antialiased ${montserrat.variable}`}
            >
                <ThemeProvider
                    attribute="class"
                    defaultTheme="system"
                    enableSystem
                    disableTransitionOnChange
                >
                    {children}
                    <Analytics />
                </ThemeProvider>
            </body>
        </html>
    );
}
