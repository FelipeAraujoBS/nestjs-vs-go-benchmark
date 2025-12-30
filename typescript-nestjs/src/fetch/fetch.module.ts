import { Module } from '@nestjs/common';
import { FetchController } from './fetch.controller';
import { FetchService } from './fetch.service';

@Module({
  providers: [FetchService],
  controllers: [FetchController],
})
export class FetchModule {}
