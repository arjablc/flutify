import { Injectable, NotFoundException } from '@nestjs/common';
import { BcryptService } from '../../common/bcrypt.service';
import { UserService } from '../user/user.service';
import { SignUpDto } from './dto/signup-user.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly bcrypt: BcryptService,
  ) {}

  async signup(signupDto: SignUpDto) {
    signupDto.password = await this.bcrypt.hash(signupDto.password);
    const user = this.userService.findByEmail(signupDto.email);
    if (!user) {
      return this.userService.create(signupDto);
    }
    throw new NotFoundException('User already exists');
  }

  async login(loginDto: any) {
    const user = await this.userService.findByEmail(loginDto.email);
    if (!user) {
      throw new NotFoundException('Invalid credentials');
    }
    const isPasswordValid = await this.bcrypt.compare(
      loginDto.password,
      user.password,
    );
    if (isPasswordValid) {
      return {
        message: 'Logged in',
        accessToken: 'token',
      };
    }
  }
}
