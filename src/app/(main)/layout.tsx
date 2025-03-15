import { NavBar } from "@/components/layouts/navbar.component";

export default function MainLayout({
    children,
}: Readonly<{
    children: React.ReactNode;
}>) {
    return <NavBar>{children}</NavBar>;
}
