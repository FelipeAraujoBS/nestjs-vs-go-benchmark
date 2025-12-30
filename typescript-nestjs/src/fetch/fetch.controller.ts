import { Controller, Get } from '@nestjs/common';
import { FetchService } from './fetch.service';

@Controller()
export class FetchController {
  constructor(private readonly fetchService: FetchService) {}

  @Get('fetch-posts')
  async fetchPost() {
    return this.fetchService.fetchPost();
  }

  @Get('aggregate')
  async aggregateData() {
    return this.fetchService.aggregateData();
  }
}
