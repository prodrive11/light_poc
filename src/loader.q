.app.opts:.Q.opt .z.x;

if[`test in key .app.opts;
  system "l src/t.q";
  system "l ", first .app.opts`test
  ];

if[`exec in key .app.opts;
  system "l ", first .app.opts`exec
  ];
