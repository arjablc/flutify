import { Controller, Get } from '@nestjs/common';
import { UserService } from './user.service';
import { BcryptService } from '../../common/bcrypt.service';

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
}
