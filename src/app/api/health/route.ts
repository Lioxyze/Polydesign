import { getHealthStatus } from '@/api/health';

export async function GET() {
  return Response.json(await getHealthStatus());
}
