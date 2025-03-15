"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { usePathname } from "next/navigation";
import SquaresIcon from "../icons/squares.icon";
import CalendarIcon from "../icons/calendar.icon";
import UserIcon from "../icons/user.icon";
import ChartIcon from "../icons/chart.icon";

interface NavBarProps {
    children: React.ReactNode;
}

export function NavBar({ children }: NavBarProps) {
    const [hasScrolled, setHasScrolled] = useState(false);
    const pathname = usePathname();

    useEffect(() => {
        const handleScroll = () => setHasScrolled(window.scrollY > 0);
        window.addEventListener("scroll", handleScroll);
        return () => window.removeEventListener("scroll", handleScroll);
    }, []);

    const navItems = [
        { href: "/", icon: SquaresIcon, label: "Home" },
        { href: "/calendar", icon: CalendarIcon, label: "Calendar" },
        { href: "/statistics", icon: ChartIcon, label: "Stats" },
        { href: "/profile", icon: UserIcon, label: "Profile" },
    ];

    return (
        <div className="w-full h-screen flex flex-col">
            {/* Desktop Navbar */}
            <header className="hidden sm:flex min-h-20 relative">
                <div
                    className={`fixed top-1 left-0 right-0 mx-auto max-w-[640px] px-12 py-4 justify-between items-center transition-all duration-300 z-10 
                        ${
                            hasScrolled
                                ? "bg-primary-foreground/80 backdrop-blur-md shadow-md rounded-lg"
                                : ""
                        }`}
                >
                    <nav className="flex justify-between w-full">
                        {navItems.map(({ href, icon: Icon, label }) => (
                            <Link
                                key={href}
                                href={href}
                                className={`flex flex-col items-center text-xs gap-1 transition-all ${
                                    pathname === href
                                        ? "text-primary font-bold"
                                        : "text-foreground"
                                }`}
                                aria-current={pathname === href ? "page" : undefined}
                            >
                                <Icon className="w-8 h-8" />
                                {label}
                            </Link>
                        ))}
                    </nav>
                </div>
            </header>

            {/* Main Content */}
            <main className="flex-1 overflow-auto p-4 sm:p-6">
                {children}
            </main>

            {/* Mobile Navbar */}
            <footer className="sm:hidden fixed bottom-0 left-0 w-full bg-background border-t border-border px-6 py-2">
                <nav className="flex justify-around items-center h-16 max-w-[640px] mx-auto">
                    {navItems.map(({ href, icon: Icon }) => (
                        <Link
                            key={href}
                            href={href}
                            className={`flex flex-col items-center text-xs transition-all ${
                                pathname === href
                                    ? "text-foreground"
                                    : "text-muted-foreground"
                            }`}
                            aria-current={pathname === href ? "page" : undefined}
                        >
                            <Icon className="w-6 h-6" />
                        </Link>
                    ))}
                </nav>
            </footer>
        </div>
    );
}
