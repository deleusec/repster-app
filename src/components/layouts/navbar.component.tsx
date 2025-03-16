"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { usePathname } from "next/navigation";
import SquaresIcon from "../icons/squares.icon";
import CalendarIcon from "../icons/calendar.icon";
import UserIcon from "../icons/user.icon";
import ChartIcon from "../icons/chart.icon";
import LogoIcon from "../icons/logo.icon";

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

    const navItemsLeft = [
        { href: "/", icon: SquaresIcon, label: "Home" },
        { href: "/calendar", icon: CalendarIcon, label: "Calendar" },
    ];

    const navItemsRight = [
        { href: "/statistics", icon: ChartIcon, label: "Stats" },
        { href: "/profile", icon: UserIcon, label: "Profile" },
    ];

    return (
        <div className="w-full h-dvh flex flex-col justify-items-stretch">
            {/* Desktop Navbar */}
            <header className="hidden sm:flex min-h-16 relative">
                <div
                    className={`fixed h-[calc(64px-8px)] top-2 left-2 right-2 mx-auto max-w-[640px] px-12 py-4 flex items-center justify-between transition-all duration-300 z-10
                        ${
                            hasScrolled
                                ? "bg-primary-foreground/80 backdrop-blur-md shadow-md rounded-lg"
                                : ""
                        }`}
                >
                    {/* Left navigation */}
                    <nav className="flex gap-6 flex-1 justify-between">
                        {navItemsLeft.map(({ href, label }) => (
                            <Link
                                key={href}
                                href={href}
                                className={`flex items-center text-xs p-2 gap-1 transition-all ${
                                    pathname === href
                                        ? "text-primary font-bold"
                                        : "text-foreground"
                                }`}
                                aria-current={
                                    pathname === href ? "page" : undefined
                                }
                            >
                                {label}
                            </Link>
                        ))}
                    </nav>

                    {/* Logo */}
                    <div className="flex-1 flex justify-center">
                        <Link
                            href="/"
                            passHref
                            className="flex items-center p-2"
                        >
                            <LogoIcon className="w-10 h-10" />
                        </Link>
                    </div>

                    {/* Right navigation */}
                    <nav className="flex gap-6 flex-1 justify-between">
                        {navItemsRight.map(({ href, label }) => (
                            <Link
                                key={href}
                                href={href}
                                className={`flex items-center text-xs p-2 gap-1 transition-all ${
                                    pathname === href
                                        ? "text-primary font-bold"
                                        : "text-foreground"
                                }`}
                                aria-current={
                                    pathname === href ? "page" : undefined
                                }
                            >
                                {label}
                            </Link>
                        ))}
                    </nav>
                </div>
            </header>

            {/* Main Content */}
            <main className="flex-1 max-sm:overflow-auto p-4 sm:p-6">
                {children}
                <div className="h-[1800px]"></div>
            </main>

            {/* Mobile Navbar */}
            <footer className="sm:hidden w-full bg-background border-t border-border px-2 pt-2 pb-[env(safe-area-inset-bottom)]">
                <nav className="flex justify-around items-stretch h-16 max-w-[640px] mx-auto">
                    {[...navItemsLeft, ...navItemsRight].map(
                        ({ href, icon: Icon }) => (
                            <Link
                                key={href}
                                href={href}
                                className={`flex flex-1 justify-center items-center text-xs transition-all ${
                                    pathname === href
                                        ? "text-foreground"
                                        : "text-muted-foreground"
                                }`}
                                aria-current={
                                    pathname === href ? "page" : undefined
                                }
                            >
                                <Icon className="w-6 h-6" />
                            </Link>
                        )
                    )}
                </nav>
            </footer>
        </div>
    );
}
