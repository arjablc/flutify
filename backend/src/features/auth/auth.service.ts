import { ConflictException, Injectable, NotFoundException, UnauthorizedException } from '@nestjs/common';
import { BcryptService } from '../../common/bcrypt.service';
import { UserService } from '../user/user.service';
import { SignUpDto } from './dto/signup-user.dto';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly bcrypt: BcryptService,
    private readonly jwt: JwtService,
  ) { }

  async signup(signupDto: SignUpDto) {
    signupDto.password = await this.bcrypt.hash(signupDto.password);
    const user = await this.userService.findByEmail(signupDto.email);
    console.log(user);
    if (!user) {
      return this.userService.create(signupDto);
    }
    throw new ConflictException('User already exists');
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
      const payload = { email: user.email, sub: user.id };
      const accessToken = await this.jwt.signAsync(payload);
      return {
        message: 'Logged in',
        accessToken: accessToken,
      };
    }
    throw new UnauthorizedException("Either email or password incorrect")
  }
}
