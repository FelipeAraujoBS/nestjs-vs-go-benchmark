import { Controller, Get, Query } from '@nestjs/common';
import { PrimesService } from './primes.service';

@Controller('primes')
export class PrimesController {
  constructor(private readonly primeService: PrimesService) {}

  @Get()
  getPrimes(@Query('n') n: string) {
    const result = this.primeService.calculatePrime(Number(n));

    return {
      count: result.length,
    };
  }
}
