import { Body, Controller, Post, UsePipes } from '@nestjs/common';
import { AuthService } from './auth.service';
import { ZodPipe } from 'src/common/pipe/zod.pipe';
import { SignUpDto, SignUpSchema } from './dto/signup-user.dto';
import { loginUserSchema, LoginUserDto } from './dto/login-user.dto';

@Controller('auth')
export class AuthController {
  constructor(
    private readonly authService: AuthService,
  ) { }

  @Post('signup')
  @UsePipes(new ZodPipe(SignUpSchema))
  async signup(@Body() createUserDto: SignUpDto) {
    const newUser = await this.authService.signup(createUserDto);
    const { password, ...user } = newUser;
    return user;
  }

  @Post('login')
  @UsePipes(new ZodPipe(loginUserSchema))
  async login(@Body() loginUserDto: LoginUserDto) {
    const message = await this.authService.login(loginUserDto);
    return message;
  }
}
