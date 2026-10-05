import { ApiStatus } from '@/components/api-status';

export default function HomePage() {
  return (
    <main className="mx-auto flex min-h-screen max-w-3xl flex-col items-start justify-center gap-6 px-6">
      <span
        aria-hidden="true"
        className="grid size-14 place-items-center rounded-2xl bg-linear-to-br from-brand to-brand-alt text-xl font-bold"
      >
        PD
      </span>
      <h1 className="text-5xl font-bold tracking-tight">PolyDesign</h1>
      <p className="text-lg text-muted">
        La plateforme francophone pour publier, partager et télécharger des modèles 3D.
      </p>
      <ApiStatus />
    </main>
  );
}
