import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrimesModule } from './primes/primes.module';
import { FetchModule } from './fetch/fetch.module';

@Module({
  imports: [PrimesModule, FetchModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
