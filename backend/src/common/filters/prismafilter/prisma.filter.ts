import {
  ArgumentsHost,
  Catch,
  ConflictException,
  ExceptionFilter,
  HttpStatus,
  NotFoundException,
} from '@nestjs/common';
import { BaseExceptionFilter } from '@nestjs/core';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { STATUS_CODES } from 'http';

@Catch(PrismaClientKnownRequestError)
export class PrismaFilter<
  PrismaClientKnownRequestError,
> extends BaseExceptionFilter {
  catch(exception: PrismaClientKnownRequestError, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse();
    if (!(exception instanceof PrismaClientKnownRequestError)) {
      return;
    }
    const errorCode = exception.code;

    switch (errorCode) {
      case 'P2002':
        response.status(HttpStatus.CONFLICT).json({
          message: 'rescource already exists',
        });
        break;
      case 'P2025':
        response.status(HttpStatus.NOT_FOUND).json({
          message: exception.message,
        });
        break;

      default:
        super.catch(exception, host);
        break;
    }
  }
}
