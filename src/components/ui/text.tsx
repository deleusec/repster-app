import { ReactNode } from "react";
import clsx from "clsx";

interface TextProps {
  variant?: "body" | "caption" | "label";
  as?: "p" | "span" | "div";
  className?: string;
  children: ReactNode;
}

const Text = ({ variant = "body", as: Tag = "p", className, children }: TextProps) => {
  const baseStyles = "text-foreground";

  const variantStyles = {
    body: "text-base",
    caption: "text-sm text-muted-foreground",
    label: "text-xs font-semibold uppercase tracking-wide text-primary",
  };

  return (
    <Tag className={clsx(baseStyles, variantStyles[variant], className)}>
      {children}
    </Tag>
  );
};

export default Text;
