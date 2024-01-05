const esbuild = require('esbuild');

esbuild.build({
  entryPoints: ['app/javascript/application.js'],
  bundle: true,
  outdir: 'app/assets/builds',
}).catch(() => process.exit(1));
