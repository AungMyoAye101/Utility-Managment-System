import { defineConfig } from 'tsup';

export default defineConfig({
  entry: ['src/index.ts'],
  // ESM bundle + inlined Prisma hits esbuild’s __require shim (no require in ESM).
  format: ['cjs'],
  platform: 'node',
  clean: true,
  outExtension() {
    return { js: '.cjs' };
  },
  external: ['@prisma/client'],
});
