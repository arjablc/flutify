import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { PrismaModule } from 'src/common/prisma/prisma.module';
import { BcryptService } from '../../common/bcrypt.service';

@Module({
  imports: [PrismaModule],
  controllers: [UserController],
  providers: [UserService, BcryptService],
  exports: [UserService],
})
export class UserModule {}
