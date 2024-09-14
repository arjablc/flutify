import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(private readonly jwt: JwtService) { }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest();
    const [type, token] = request.headers.authorization?.split(' ') ?? [];
    if (type !== 'Bearer') {
      throw new UnauthorizedException();
    }
    try {
      const isValid = await this.jwt.verifyAsync(token, {
        secret: process.env.JWT_SECRET,
      });
      if (isValid) {
        console.log(isValid);
        request['user'] = isValid;
        return true;
      }
      return false;
    } catch {
      throw new UnauthorizedException();

    }
  }
}
