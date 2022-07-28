#include "HsFFI.h"
#ifdef __GLASGOW_HASKELL__
#include "Rts.h"
#endif
#include "cabal_macros.h"

extern void *example_hs_init();
extern void example_hs_release(void *);

static _Bool initialized = 0;

extern
void *example_init(void)
{
    if (!initialized) {
        int argc = 1;
        char *argv[] = { "example", NULL };
        char **pargv = argv;

#ifdef __GLASGOW_HASKELL__
        RtsConfig conf = defaultRtsConfig;
        conf.rts_opts_enabled = RtsOptsAll;
        hs_init_ghc(&argc, &pargv, conf);
#else
        hs_init(&argc, &argv);
#endif

        initialized = 1;
    }

    return example_hs_init();
}

extern
void example_release(void* mod)
{
    example_hs_release(mod);

    // Note that we do not call hs_exit() here because GHC currently
    // does not support reinitializing the RTS after shutdown.
}
