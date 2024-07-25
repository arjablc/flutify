import { z } from 'zod';

function requiredErrorMessageGen(field: string): string {
  return `${field} must be provided`;
}

export const SignUpSchema = z.object({
  email: z
    .string({ required_error: requiredErrorMessageGen('Email') })
    .email({ message: 'Must be a valid email' }),
  name: z
    .string({ required_error: requiredErrorMessageGen('Name') })
    .max(50, 'Username must be 50 characters at max'),
  password: z
    .string({
      required_error: requiredErrorMessageGen('Password'),
    })
    .min(6, 'Password must be at least 6 characters long'),
});

export type SignUpDto = z.infer<typeof SignUpSchema>;
