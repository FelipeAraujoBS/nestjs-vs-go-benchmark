import { Injectable } from '@nestjs/common';

@Injectable()
export class FetchService {
  async fetchPost() {
    const response = await fetch('https://jsonplaceholder.typicode.com/posts');
    return response.json();
  }

  async aggregateData() {
    const promises = Array.from({ length: 10 }, (_, i) =>
      fetch(`https://jsonplaceholder.typicode.com/posts/${i + 1}`).then((res) =>
        res.json(),
      ),
    );

    return Promise.all(promises);
  }
}
