import { Controller, Get, Param, Req, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { BcryptService } from '../../common/bcrypt.service';
import { AuthGuard } from '../auth/guards/auth.guard';

@Controller('user')
export class UserController {
  constructor(
    private readonly userService: UserService,
    private readonly bcrypt: BcryptService,
  ) {}

  @Get('deleteAll')
  async deleteAllUsers() {
    return await this.userService.deleteAll();
  }

  @UseGuards(AuthGuard)
  @Get('me')
  async getMe(@Req() req) {
    return await this.userService.findById(req.user.sub);
  }
}
