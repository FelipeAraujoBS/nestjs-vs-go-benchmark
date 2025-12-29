import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrimesModule } from './primes/primes.module';

@Module({
  imports: [PrimesModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
