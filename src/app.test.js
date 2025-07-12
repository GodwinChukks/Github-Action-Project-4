const app = require('./app');
const supertest = require('supertest');
// const {describe, it } = require('jest-circus');
const request = supertest(app);

describe('/testnode endpoint', () => {
  it('should return a response', async () => {
    const response = await request.get('/testNode');
    expect(response.status).toBe(200);
    expect(response.text).toBe('Yes the testnode endpoint is working');
 });
});
