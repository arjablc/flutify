import { Module } from '@nestjs/common';
import { APP_FILTER } from '@nestjs/core';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserModule } from './features/user/user.module';
import { PrismaModule } from './common/prisma/prisma.module';
import { PrismaFilter } from './common/filters/prismafilter/prisma.filter';
import { ZodFilter } from './common/filters/zodfilter/zod.filter';
import { AuthModule } from './features/auth/auth.module';

@Module({
  imports: [UserModule, PrismaModule, AuthModule],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_FILTER,
      useClass: PrismaFilter,
    },
    {
      provide: APP_FILTER,
      useClass: ZodFilter,
    },
  ],
})
export class AppModule {}
