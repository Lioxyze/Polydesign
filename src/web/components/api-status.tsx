'use client';

import { useQuery } from '@tanstack/react-query';
import { getHealth } from '@/web/api-client';

export function ApiStatus() {
  const { data, isPending, isError } = useQuery({ queryKey: ['health'], queryFn: getHealth });

  let label = "Vérification de l'API...";
  let color = 'bg-muted';

  if (isError) {
    label = 'API injoignable';
    color = 'bg-danger';
  } else if (data) {
    label =
      data.database === 'up'
        ? 'API et base de données connectées'
        : 'API connectée, base de données indisponible';
    color = data.database === 'up' ? 'bg-success' : 'bg-danger';
  }

  return (
    <p
      role="status"
      aria-live="polite"
      className="inline-flex items-center gap-2 rounded-full border border-line bg-surface px-4 py-2 text-sm text-muted"
    >
      <span
        aria-hidden="true"
        className={`size-2.5 rounded-full ${color} ${isPending ? 'animate-pulse' : ''}`}
      />
      {label}
    </p>
  );
}
