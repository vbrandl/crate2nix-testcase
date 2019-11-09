{ lib, buildRustCrate, buildRustCrateHelpers }:
with buildRustCrateHelpers;
let inherit (lib.lists) fold;
    inherit (lib.attrsets) recursiveUpdate;
in
rec {

# adler32-1.0.4

  crates.adler32."1.0.4" = deps: { features?(features_.adler32."1.0.4" deps {}) }: buildRustCrate {
    crateName = "adler32";
    version = "1.0.4";
    description = "Minimal Adler32 implementation for Rust.";
    authors = [ "Remi Rampin <remirampin@gmail.com>" ];
    sha256 = "157bfkgcy4p3cclfv378x7clxcj3l23jj7sckjbqkmdjbi72y134";
  };
  features_.adler32."1.0.4" = deps: f: updateFeatures f (rec {
    adler32."1.0.4".default = (f.adler32."1.0.4".default or true);
  }) [];


# end
# cfg-if-0.1.10

  crates.cfg_if."0.1.10" = deps: { features?(features_.cfg_if."0.1.10" deps {}) }: buildRustCrate {
    crateName = "cfg-if";
    version = "0.1.10";
    description = "A macro to ergonomically define an item depending on a large number of #[cfg]\nparameters. Structured like an if-else chain, the first matching branch is the\nitem that gets emitted.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    edition = "2018";
    sha256 = "0x52qzpbyl2f2jqs7kkqzgfki2cpq99gpfjjigdp8pwwfqk01007";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."cfg_if"."0.1.10" or {});
  };
  features_.cfg_if."0.1.10" = deps: f: updateFeatures f (rec {
    cfg_if = fold recursiveUpdate {} [
      { "0.1.10"."compiler_builtins" =
        (f.cfg_if."0.1.10"."compiler_builtins" or false) ||
        (f.cfg_if."0.1.10".rustc-dep-of-std or false) ||
        (cfg_if."0.1.10"."rustc-dep-of-std" or false); }
      { "0.1.10"."core" =
        (f.cfg_if."0.1.10"."core" or false) ||
        (f.cfg_if."0.1.10".rustc-dep-of-std or false) ||
        (cfg_if."0.1.10"."rustc-dep-of-std" or false); }
      { "0.1.10".default = (f.cfg_if."0.1.10".default or true); }
    ];
  }) [];


# end
# crc32fast-1.2.0

  crates.crc32fast."1.2.0" = deps: { features?(features_.crc32fast."1.2.0" deps {}) }: buildRustCrate {
    crateName = "crc32fast";
    version = "1.2.0";
    description = "Fast, SIMD-accelerated CRC32 (IEEE) checksum computation";
    authors = [ "Sam Rijs <srijs@airpost.net>" "Alex Crichton <alex@alexcrichton.com>" ];
    sha256 = "1mx88ndqln6vzg7hjhjp8b7g0qggpqggsjrlsdqrfsrbpdzffcn8";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."crc32fast"."1.2.0"."cfg_if"}" deps)
    ]);
    features = mkFeatures (features."crc32fast"."1.2.0" or {});
  };
  features_.crc32fast."1.2.0" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.crc32fast."1.2.0".cfg_if}".default = true;
    crc32fast = fold recursiveUpdate {} [
      { "1.2.0"."std" =
        (f.crc32fast."1.2.0"."std" or false) ||
        (f.crc32fast."1.2.0".default or false) ||
        (crc32fast."1.2.0"."default" or false); }
      { "1.2.0".default = (f.crc32fast."1.2.0".default or true); }
    ];
  }) [
    (features_.cfg_if."${deps."crc32fast"."1.2.0"."cfg_if"}" deps)
  ];


# end
# flate2-1.0.12

  crates.flate2."1.0.12" = deps: { features?(features_.flate2."1.0.12" deps {}) }: buildRustCrate {
    crateName = "flate2";
    version = "1.0.12";
    description = "Bindings to miniz.c for DEFLATE compression and decompression exposed as\nReader/Writer streams. Contains bindings for zlib, deflate, and gzip-based\nstreams.\n";
    authors = [ "Alex Crichton <alex@alexcrichton.com>" ];
    edition = "2018";
    sha256 = "11bw2rp905w43pc4fxgsmal93zf26zkfkhk8h0ac5ik3spy0drj6";
    dependencies = mapFeatures features ([
      (crates."cfg_if"."${deps."flate2"."1.0.12"."cfg_if"}" deps)
      (crates."crc32fast"."${deps."flate2"."1.0.12"."crc32fast"}" deps)
      (crates."libc"."${deps."flate2"."1.0.12"."libc"}" deps)
    ]
      ++ (if features.flate2."1.0.12".miniz_oxide or false then [ (crates.miniz_oxide."${deps."flate2"."1.0.12".miniz_oxide}" deps) ] else []))
      ++ (if cpu == "wasm32" && !(kernel == "emscripten") then mapFeatures features ([
      (crates."miniz_oxide"."${deps."flate2"."1.0.12"."miniz_oxide"}" deps)
    ]) else []);
    features = mkFeatures (features."flate2"."1.0.12" or {});
  };
  features_.flate2."1.0.12" = deps: f: updateFeatures f (rec {
    cfg_if."${deps.flate2."1.0.12".cfg_if}".default = true;
    crc32fast."${deps.flate2."1.0.12".crc32fast}".default = true;
    flate2 = fold recursiveUpdate {} [
      { "1.0.12"."futures" =
        (f.flate2."1.0.12"."futures" or false) ||
        (f.flate2."1.0.12".tokio or false) ||
        (flate2."1.0.12"."tokio" or false); }
      { "1.0.12"."libz-sys" =
        (f.flate2."1.0.12"."libz-sys" or false) ||
        (f.flate2."1.0.12".zlib or false) ||
        (flate2."1.0.12"."zlib" or false); }
      { "1.0.12"."miniz_oxide" =
        (f.flate2."1.0.12"."miniz_oxide" or false) ||
        (f.flate2."1.0.12".rust_backend or false) ||
        (flate2."1.0.12"."rust_backend" or false); }
      { "1.0.12"."rust_backend" =
        (f.flate2."1.0.12"."rust_backend" or false) ||
        (f.flate2."1.0.12".default or false) ||
        (flate2."1.0.12"."default" or false); }
      { "1.0.12"."tokio-io" =
        (f.flate2."1.0.12"."tokio-io" or false) ||
        (f.flate2."1.0.12".tokio or false) ||
        (flate2."1.0.12"."tokio" or false); }
      { "1.0.12".default = (f.flate2."1.0.12".default or true); }
    ];
    libc."${deps.flate2."1.0.12".libc}".default = true;
    miniz_oxide."${deps.flate2."1.0.12".miniz_oxide}".default = true;
  }) [
    (features_.cfg_if."${deps."flate2"."1.0.12"."cfg_if"}" deps)
    (features_.crc32fast."${deps."flate2"."1.0.12"."crc32fast"}" deps)
    (features_.libc."${deps."flate2"."1.0.12"."libc"}" deps)
    (features_.miniz_oxide."${deps."flate2"."1.0.12"."miniz_oxide"}" deps)
    (features_.miniz_oxide."${deps."flate2"."1.0.12"."miniz_oxide"}" deps)
  ];


# end
# libc-0.2.65

  crates.libc."0.2.65" = deps: { features?(features_.libc."0.2.65" deps {}) }: buildRustCrate {
    crateName = "libc";
    version = "0.2.65";
    description = "Raw FFI bindings to platform libraries like libc.\n";
    authors = [ "The Rust Project Developers" ];
    sha256 = "0nx1n3xvwj2ikw1d6v17154jx2sb9sgrv6fwbnq79c614a3mhmad";
    build = "build.rs";
    dependencies = mapFeatures features ([
]);
    features = mkFeatures (features."libc"."0.2.65" or {});
  };
  features_.libc."0.2.65" = deps: f: updateFeatures f (rec {
    libc = fold recursiveUpdate {} [
      { "0.2.65"."align" =
        (f.libc."0.2.65"."align" or false) ||
        (f.libc."0.2.65".rustc-dep-of-std or false) ||
        (libc."0.2.65"."rustc-dep-of-std" or false); }
      { "0.2.65"."rustc-std-workspace-core" =
        (f.libc."0.2.65"."rustc-std-workspace-core" or false) ||
        (f.libc."0.2.65".rustc-dep-of-std or false) ||
        (libc."0.2.65"."rustc-dep-of-std" or false); }
      { "0.2.65"."std" =
        (f.libc."0.2.65"."std" or false) ||
        (f.libc."0.2.65".default or false) ||
        (libc."0.2.65"."default" or false) ||
        (f.libc."0.2.65".use_std or false) ||
        (libc."0.2.65"."use_std" or false); }
      { "0.2.65".default = (f.libc."0.2.65".default or true); }
    ];
  }) [];


# end
# miniz_oxide-0.3.5

  crates.miniz_oxide."0.3.5" = deps: { features?(features_.miniz_oxide."0.3.5" deps {}) }: buildRustCrate {
    crateName = "miniz_oxide";
    version = "0.3.5";
    description = "DEFLATE compression and decompression library rewritten in Rust based on miniz";
    authors = [ "Frommi <daniil.liferenko@gmail.com>" "oyvindln <oyvindln@users.noreply.github.com>" ];
    edition = "2018";
    sha256 = "0h8zwqs0j2qmrah7zxcv39bc6w25aq12vmy3rwjajdl1djb6rf82";
    dependencies = mapFeatures features ([
      (crates."adler32"."${deps."miniz_oxide"."0.3.5"."adler32"}" deps)
    ]);
  };
  features_.miniz_oxide."0.3.5" = deps: f: updateFeatures f (rec {
    adler32."${deps.miniz_oxide."0.3.5".adler32}".default = true;
    miniz_oxide."0.3.5".default = (f.miniz_oxide."0.3.5".default or true);
  }) [
    (features_.adler32."${deps."miniz_oxide"."0.3.5"."adler32"}" deps)
  ];


# end
}
