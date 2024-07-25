import { z } from 'zod';

function requiredErrorMessageGen(field: string): string {
  return `${field} must be provided`;
}

export const loginUserSchema = z.object({
  email: z
    .string({ required_error: requiredErrorMessageGen('Email') })
    .email({ message: 'Must be a valid email' }),

  password: z
    .string({
      required_error: requiredErrorMessageGen('Password'),
    })
    .min(6, 'Password must be at least 6 characters long'),
});

export type LoginUserDto = z.infer<typeof loginUserSchema>;
