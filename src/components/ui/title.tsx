import { ReactNode } from "react";
import { JSX } from "react/jsx-runtime";
import clsx from "clsx";

interface TitleProps {
  level?: 1 | 2 | 3 | 4;
  className?: string;
  children: ReactNode;
}

const Title = ({ level = 1, className, children }: TitleProps) => {
  const Tag = `h${level}` as keyof JSX.IntrinsicElements;

  const titleStyles = {
    1: "text-4xl font-semibold text-primary",
    2: "text-3xl font-semibold text-primary",
    3: "text-2xl font-medium text-primary-foreground",
    4: "text-xl font-medium text-muted-foreground",
  };

  return (
    <Tag className={clsx("text-foreground", titleStyles[level], className)}>
      {children}
    </Tag>
  );
};

export default Title;
