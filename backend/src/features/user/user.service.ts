import { Injectable } from '@nestjs/common';

import { PrismaService } from 'src/common/prisma/prisma.service';
import { SignUpDto } from '../auth/dto/signup-user.dto';

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

  async create(createUserDto: SignUpDto) {
    return await this.prisma.user.create({
      data: createUserDto,
      select: this.secureSelection,
    });
  }

  async findByEmail(email: string) {
    return await this.prisma.user.findUnique({ where: { email } });
  }
  async findById(id: string) {
    console.log(id);
    return this.prisma.user.findUnique({
      where: { id: id },
      select: this.secureSelection,
    });
  }
  async deleteAll() {
    return await this.prisma.user.deleteMany({});
  }
}
