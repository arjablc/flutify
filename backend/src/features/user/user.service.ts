import { Injectable } from '@nestjs/common';
import { CreateUserDto } from '../auth/dto/signup-user.dto';

import { PrismaService } from 'src/common/prisma/prisma.service';

@Injectable()
export class UserService {
  constructor(private prisma: PrismaService) {}

  secureSelection = {
    id: true,
    name: true,
    email: true,
    createdAt: false,
    updatedAt: false,
    password: false,
  };

  async create(createUserDto: CreateUserDto) {
    return await this.prisma.user.create({
      data: createUserDto,
      select: this.secureSelection,
    });
  }

  async findByEmail(email: string) {
    return await this.prisma.user.findUnique({ where: { email } });
  }

  async deleteAll() {
    return await this.prisma.user.deleteMany({});
  }
}
