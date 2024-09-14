import { Injectable } from '@nestjs/common';
import { PrismaClient as Prismaclient } from '@prisma/client';

@Injectable()
export class PrismaService extends Prismaclient {}
