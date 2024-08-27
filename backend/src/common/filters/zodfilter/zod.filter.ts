import { ArgumentsHost, Catch, ExceptionFilter } from '@nestjs/common';
import { ZodError } from 'zod';

@Catch(ZodError)
export class ZodFilter<ZodError> implements ExceptionFilter {
  catch(exception: ZodError, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse();
    if (exception instanceof ZodError) {
      const err = exception.issues.map((issue) => {
        return { path: issue.path[0], message: issue.message };
      });
      response.status(422).json({
        message: 'Bad Request',
        detail: err,
      });
    }
  }
}
