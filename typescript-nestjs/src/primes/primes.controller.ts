import { Controller, Get, Query } from '@nestjs/common';
import { PrimesService } from './primes.service';

@Controller('primes')
export class PrimesController {
  constructor(private readonly primeService: PrimesService) {}

  @Get()
  getPrimes(@Query('n') n: string) {
    const limit = Number(n);
    const start = Date.now();
    const result = this.primeService.calculatePrime(limit);
    const elapsed = Date.now() - start;

    return {
      count: result.length,
      elapsedMs: elapsed,
    };
  }
}
