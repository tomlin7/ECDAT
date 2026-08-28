import { Button as ButtonPrimitive } from "@base-ui/react/button"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

const buttonVariants = cva(
  "group/button inline-flex shrink-0 items-center justify-center rounded-[6px] bg-clip-padding text-[13px] font-medium whitespace-nowrap outline-none select-none focus-visible:ring-2 focus-visible:ring-ring/40 disabled:pointer-events-none disabled:opacity-50 aria-invalid:ring-2 aria-invalid:ring-destructive/20 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
  {
    variants: {
      variant: {
        default:
          "border border-[#7a71e8] border-b-[3px] border-b-[#4438a8] bg-[#635dff] text-white shadow-none transition-[transform,border-bottom-width,background-color] duration-75 hover:bg-[#6f68ff] active:translate-y-[2px] active:border-b",
        tactile:
          "border border-[#3a3a46] border-b-[3px] border-b-[#121218] bg-[#2a2a32] text-[#f0edf6] shadow-none transition-[transform,border-bottom-width,background-color] duration-75 hover:bg-[#32323c] active:translate-y-[2px] active:border-b",
        outline:
          "border border-[#3a3a46] border-b-[3px] border-b-[#121218] bg-[#2a2a32] text-foreground shadow-none transition-[transform,border-bottom-width,background-color] duration-75 hover:bg-[#32323c] active:translate-y-[2px] active:border-b",
        secondary:
          "border border-[#3a3a46] border-b-[3px] border-b-[#121218] bg-[#2c2c35] text-secondary-foreground shadow-none transition-[transform,border-bottom-width,background-color] duration-75 hover:bg-[#34343f] active:translate-y-[2px] active:border-b",
        ghost:
          "border border-transparent bg-transparent text-muted-foreground shadow-none hover:bg-muted hover:text-foreground active:translate-y-0",
        destructive:
          "border border-destructive/30 border-b-[3px] border-b-destructive/50 bg-destructive/15 text-destructive shadow-none hover:bg-destructive/25 active:translate-y-[2px] active:border-b",
        link: "border-transparent bg-transparent text-primary underline-offset-4 shadow-none hover:underline active:translate-y-0",
      },
      size: {
        default:
          "h-8 gap-1.5 px-2.5 has-data-[icon=inline-end]:pr-2 has-data-[icon=inline-start]:pl-2",
        xs: "h-6 gap-1 px-2 text-xs has-data-[icon=inline-end]:pr-1.5 has-data-[icon=inline-start]:pl-1.5 [&_svg:not([class*='size-'])]:size-3",
        sm: "h-7 gap-1 px-2.5 text-[0.8rem] has-data-[icon=inline-end]:pr-1.5 has-data-[icon=inline-start]:pl-1.5 [&_svg:not([class*='size-'])]:size-3.5",
        lg: "h-9 gap-1.5 px-3 has-data-[icon=inline-end]:pr-2 has-data-[icon=inline-start]:pl-2",
        icon: "size-8 p-0",
        "icon-xs": "size-6 p-0 [&_svg:not([class*='size-'])]:size-3",
        "icon-sm": "size-7 p-0",
        "icon-lg": "size-9 p-0",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)

function Button({
  className,
  variant = "default",
  size = "default",
  ...props
}: ButtonPrimitive.Props & VariantProps<typeof buttonVariants>) {
  return (
    <ButtonPrimitive
      data-slot="button"
      className={cn(buttonVariants({ variant, size, className }))}
      {...props}
    />
  )
}

export { Button, buttonVariants }
