;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2020, 2021 Nicolò Balzarotti <nicolo@nixo.xyz>
;;; Copyright © 2021 Simon Tournier <zimon.toutoune@gmail.com>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (gnu packages julia-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system julia)
  #:use-module (gnu packages tls))

(define-public julia-abstractffts
  (package
    (name "julia-abstractffts")
    (version "1.0.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaMath/AbstractFFTS.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0083pwdyxjb04i330ir9pc8kmp4bwk59lx1jgc9qi05y8j7xzbp0"))))
    (build-system julia-build-system)
    (inputs                             ;required for tests
     `(("julia-unitful" ,julia-unitful)))
    (home-page "https://github.com/JuliaGPU/Adapt.jl")
    (synopsis "General framework for fast Fourier transforms (FFTs)")
    (description "This package allows multiple FFT packages to co-exist with
the same underlying @code{fft(x)} and @code{plan_fft(x)} interface.  It is
mainly not intended to be used directly.  Instead, developers of packages that
implement FFTs (such as @code{FFTW.jl} or @code{FastTransforms.jl}) extend the
types/functions defined in AbstractFFTs.")
    (license license:expat)))

(define-public julia-adapt
  (package
    (name "julia-adapt")
    (version "3.1.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaGPU/Adapt.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1lks6k3a1gvwlplld47nh6xfy3nnlpc0vhkzg6zg0qn33qdmavrg"))))
    (build-system julia-build-system)
    (home-page "https://github.com/JuliaGPU/Adapt.jl")
    (synopsis "Package providing the @code{adapt} function, similar to @code{convert}")
    (description "This Julia package provides the @code{adapt(T, x)} function
acts like @code{convert(T, x)}, but without the restriction of returning a
@code{T}.  This allows you to \"convert\" wrapper types like @code{Adjoint} to
be GPU compatible without throwing away the wrapper.")
    (license license:expat)))

(define-public julia-benchmarktools
  (package
    (name "julia-benchmarktools")
    (version "0.5.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaCI/BenchmarkTools.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0nsx21m3i5h22lkgyrmfj6r085va6ag40khwssqs8y7l0wz98lvp"))))
    (build-system julia-build-system)
    (propagated-inputs `(("julia-json" ,julia-json)))
    (home-page "https://github.com/JuliaCI/BenchmarkTools.jl")
    (synopsis "Benchmarking framework for the Julia language")
    (description "@code{BenchmarkTools.jl} makes performance tracking of Julia
code easy by supplying a framework for writing and running groups of
benchmarks as well as comparing benchmark results.")
    (license license:expat)))

(define-public julia-bufferedstreams
  (package
    (name "julia-bufferedstreams")
    (version "1.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/BioJulia/BufferedStreams.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0sf4sxbq55mg2pwxyxf0c839z1lk0yxg8nmb7617bfbvw31cp88z"))))
    (build-system julia-build-system)
    ;; The package is old and tests are using undefined functions.  They also
    ;; freeze, see
    ;; https://travis-ci.org/BioJulia/BufferedStreams.jl/jobs/491050182
    (arguments
     '(#:tests? #f
       #:julia-package-name "BufferedStreams"))
    (propagated-inputs `(("julia-compat" ,julia-compat)))
    (home-page "https://github.com/BioJulia/BufferedStreams.jl")
    (synopsis "Fast composable IO streams")
    (description "@code{BufferedStreams.jl} provides buffering for IO
operations.  It can wrap any @code{IO} type automatically making incremental
reading and writing faster.")
    (license license:expat)))

(define-public julia-chainrulescore
  (package
    (name "julia-chainrulescore")
    (version "0.9.29")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaDiff/ChainRulesCore.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1k0iayw39n1ikkkhvyi4498vsnzc94skqs41gnd15632gxjfvki4"))))
    (build-system julia-build-system)
    (inputs                             ;required for tests
     `(("julia-benchmarktools" ,julia-benchmarktools)
       ("julia-staticarrays" ,julia-staticarrays)))
    (propagated-inputs
     `(("julia-compat" ,julia-compat)))
    (home-page "https://github.com/JuliaDiff/ChainRulesCore.jl")
    (synopsis "Common utilities used by downstream automatic differentiation tools")
    (description "The package provides a light-weight dependency for defining
sensitivities for functions without the need to depend on ChainRules itself.")
    (license license:expat)))

(define-public julia-colors
  (package
    (name "julia-colors")
    (version "0.12.6")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaGraphics/Colors.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "156zsszgwh6bmznsan0zyha6yvcxw3c5mvc5vr2qfsgxbyh36ln6"))))
    (build-system julia-build-system)
    (propagated-inputs
     `(("julia-colortypes" ,julia-colortypes)
       ("julia-fixedpointnumbers" ,julia-fixedpointnumbers)
       ("julia-reexport" ,julia-reexport)))
    (home-page "https://github.com/JuliaGraphics/Colors.jl")
    (synopsis "Tools for dealing with color")
    (description "This package provides a wide array of functions for dealing
with color.  This includes conversion between colorspaces, measuring distance
between colors, simulating color blindness, parsing colors, and generating
color scales for graphics.")
    (license license:expat)))

(define-public julia-colortypes
  (package
    (name "julia-colortypes")
    (version "0.10.12")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaGraphics/ColorTypes.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "176hr3qbz7lncmykks2qaj3cqisnzim7wi5jwsca9ld26wwyvyqq"))))
    (arguments
     '(#:tests? #f))                    ;require Documenter, not packaged yet
    (build-system julia-build-system)
    (propagated-inputs
     `(("julia-fixedpointnumbers" ,julia-fixedpointnumbers)))
    (home-page "https://github.com/JuliaGraphics/ColorTypes.jl")
    (synopsis "Basic color types and constructor")
    (description "This minimalistic package serves as the foundation for
working with colors in Julia.  It defines basic color types and their
constructors, and sets up traits and show methods to make them easier to work
with.")
    (license license:expat)))

(define-public julia-compat
  (package
    (name "julia-compat")
    (version "3.25.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaLang/Compat.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1m4r5i8mq29xjp3mllh6047n5a78sdyld57m15anrnsjgaapcgby"))))
    (build-system julia-build-system)
    (home-page "https://github.com/JuliaLang/Compat.jl")
    (synopsis "Compatibility across Julia versions")
    (description "The Compat package is designed to ease interoperability
between older and newer versions of the Julia language.  The Compat package
provides a macro that lets you use the latest syntax in a backwards-compatible
way.")
    (license license:expat)))

(define-public julia-constructionbase
  (let ((commit "de77e2865b554f9b078fd8c35b593cce0554ae02"))
    (package
      (name "julia-constructionbase")
      (version "1.1.0")                 ;tag not created upstream
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/JuliaObjects/ConstructionBase.jl")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1y79sfj0rds1skl9j16p9161hwa9khm0xc2m4hgjcbh5zzvyr57v"))))
      (build-system julia-build-system)
      (home-page "https://juliaobjects.github.io/ConstructionBase.jl/dev/")
      (synopsis "Primitive functions for construction of objects")
      (description "This very lightweight package provides primitive functions
for construction of objects.")
      (license license:expat))))

(define-public julia-datastructures
  (package
    (name "julia-datastructures")
    (version "0.18.9")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaCollections/DataStructures.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0hdqp8ipsqdw5bqqkdvz4j6n67x80sj5azr9vzyxwjfsgkfbnk2l"))))
    (propagated-inputs
     `(("julia-compat" ,julia-compat)
       ("julia-orderedcollections" ,julia-orderedcollections)))
    (build-system julia-build-system)
    (home-page "https://github.com/JuliaCollections/DataStructures.jl")
    (synopsis "Julia module providing different data structures")
    (description "This package implements a variety of data structures,
including, @code{CircularBuffer}, @code{Queue}, @code{Stack},
@code{Accumulators}, @code{LinkedLists}, @code{SortedDicts} and many others.")
    (license license:expat)))

(define-public julia-example
  (let ((commit "f968c69dea24f851d0c7e686db23fa55826b5388"))
    (package
      (name "julia-example")
      (version "0.5.4")                   ;tag not created upstream
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/JuliaLang/Example.jl")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1v3z0d6gh6wfbypffy9m9rhh36px6fm5wjzq0y6rbmc95r0qpqlx"))))
      (build-system julia-build-system)
      (home-page "https://github.com/JuliaLang/Example.jl")
      (synopsis "Module providing examples")
      (description "This package provides various examples.")
      (license license:expat))))

(define-public julia-fixedpointnumbers
  (package
    (name "julia-fixedpointnumbers")
    (version "0.8.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaMath/FixedPointNumbers.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0j0n40n04q9sk68wh9jq90m6c67k4ws02k41djjzkrqmpzv4rcdi"))))
    (build-system julia-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'disable-failing-test
           (lambda* (#:key outputs #:allow-other-keys)
             (substitute* "test/fixed.jl"
               ;; A deprecation warning is not thrown
               (("@test_logs.*:warn" all) (string-append "# " all)))
             #t)))))
    (propagated-inputs `(("julia-compat" ,julia-compat)))
    (home-page "https://github.com/JuliaMath/FixedPointNumbers.jl")
    (synopsis "Fixed point types for Julia")
    (description "@code{FixedPointNumbers.jl} implements fixed-point number
types for Julia.  A fixed-point number represents a fractional, or
non-integral, number.  In contrast with the more widely known floating-point
numbers, with fixed-point numbers the decimal point doesn't \"float\":
fixed-point numbers are effectively integers that are interpreted as being
scaled by a constant factor.  Consequently, they have a fixed number of
digits (bits) after the decimal (radix) point.")
    (license license:expat)))

(define-public julia-http
  (package
    (name "julia-http")
    (version "0.9.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaWeb/HTTP.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0ij0yci13c46p92m4zywvcs02nn8pm0abyfffiyhxvva6hq48lyl"))))
    (build-system julia-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (add-before 'install 'disable-network-tests
           (lambda _
             (substitute* "test/runtests.jl"
               (("\"async.jl") "# \"async.jl")
               (("\"client.jl") "# \"client.jl"))
             (substitute* "test/aws4.jl"
               (("@testset.*HTTP.request with AWS authentication.*" all)
                (string-append all "return\n")))
             (substitute* "test/insert_layers.jl"
               (("@testset.*Inserted final layer runs handler.*" all)
                (string-append all "return\n")))
             (substitute* "test/multipart.jl"
               (("@testset \"Setting of Content-Type.*" all)
                (string-append all "return\n"))
               (("@testset \"Deprecation of .*" all)
                (string-append all "return\n")))
             (substitute* "test/websockets.jl"
               (("@testset.*External Host.*" all)
                (string-append all "return\n")))
             (substitute* "test/messages.jl"
               (("@testset.*Read methods.*" all)
                (string-append all "return\n"))
               (("@testset.*Body - .*" all)
                (string-append all "return\n"))
               (("@testset.*Write to file.*" all)
                (string-append all "return\n")))
             #t)))))
    (propagated-inputs
     `(("julia-inifile" ,julia-inifile)
       ("julia-mbedtls" ,julia-mbedtls)
       ("julia-uris" ,julia-uris)))
    ;; required for tests
    (inputs
     `(("julia-json" ,julia-json)
       ("julia-bufferedstreams" ,julia-bufferedstreams)))
    (home-page "https://juliaweb.github.io/HTTP.jl/")
    (synopsis "HTTP support for Julia")
    (description "@code{HTTP.jl} is a Julia library for HTTP Messages,
implementing both a client and a server.")
    (license license:expat)))

(define-public julia-inifile
  (package
    (name "julia-inifile")
    (version "0.5.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaIO/IniFile.jl")
             (commit "8ba59958495fa276d6489d2c3903e765d75e0bc0")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "11h6f99jpbg729lplw841m68jprka7q3n8yw390bndlmcdsjabpd"))))
    (build-system julia-build-system)
    (home-page "https://github.com/JuliaIO/IniFile.jl")
    (synopsis "Reading Windows-style INI files")
    (description "This is a Julia package that defines an IniFile type that
allows to interface with @file{.ini} files.")
    (license license:expat)))

(define-public julia-irtools
  (package
    (name "julia-irtools")
    (version "0.4.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/FluxML/IRTools.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0wwzy77jcdnffnd5fr6xan7162g4wydz67igrq82wflwnrhlcx5y"))))
    (arguments
     '(#:tests? #f))                    ;require Documenter, not packaged yet
    (build-system julia-build-system)
    (propagated-inputs
     `(("julia-macrotools" ,julia-macrotools)))
    (home-page "https://github.com/FluxML/IRTools.jl")
    (synopsis "Simple and flexible IR format")
    (description "This package provides a simple and flexible IR format,
expressive enough to work with both lowered and typed Julia code, as well as
external IRs.  It can be used with Julia metaprogramming tools such as
Cassette.")
    (license license:expat)))

(define-public julia-jllwrappers
  (package
    (name "julia-jllwrappers")
    (version "1.2.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaPackaging/JLLWrappers.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1sj3mi2dcc13apqfpy401wic5n0pgbck1p98b2g3zw0mln9s83m4"))))
    (arguments
     ;; Wants to download stuff
     '(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'custom-override-path
           (lambda* (#:key inputs #:allow-other-keys)
             ;; Make @generate_wrapper_header take an optional argument that
             ;; guix packagers can pass to override the default "override"
             ;; binary path.  This won't be needed when something like
             ;; https://github.com/JuliaPackaging/JLLWrappers.jl/pull/27
             ;; will be merged.
             (substitute* "src/wrapper_generators.jl"
               (("generate_wrapper_header.*")
                "generate_wrapper_header(src_name, override_path = nothing)\n")
               (("pkg_dir = .*" all)
                (string-append
                 all "\n" "override = something(override_path,"
                 "joinpath(dirname(pkg_dir), \"override\"))\n"))
               (("@static if isdir.*") "@static if isdir($override)\n")
               (("return joinpath.*") "return $override\n"))
             #t)))))
    (build-system julia-build-system)
    (home-page "https://github.com/JuliaPackaging/JLLWrappers.jl")
    (synopsis "Julia macros used by JLL packages")
    (description "This package contains Julia macros that enable JLL packages
to generate themselves.  It is not intended to be used by users, but rather is
used in autogenerated packages via @code{BinaryBuilder.jl}.")
    (license license:expat)))

(define-public julia-json
  (package
    (name "julia-json")
    (version "0.21.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaIO/JSON.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1f9k613kbknmp4fgjxvjaw4d5sfbx8a5hmcszmp1w9rqfqngjx9m"))))
    (build-system julia-build-system)
    (propagated-inputs
     `(("julia-datastructures" ,julia-datastructures)
       ("julia-fixedpointnumbers" ,julia-fixedpointnumbers)
       ("julia-parsers" ,julia-parsers)
       ("julia-offsetarrays" ,julia-offsetarrays)))
    (home-page "https://github.com/JuliaIO/JSON.jl")
    (synopsis "JSON parsing and printing library for Julia")
    (description "@code{JSON.jl} is a pure Julia module which supports parsing
and printing JSON documents.")
    (license license:expat)))

(define-public julia-macrotools
  (package
    (name "julia-macrotools")
    (version "0.5.6")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/FluxML/MacroTools.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0k4z2hyasd9cwxf4l61zk3w4ajs44k69wx6z1ghdn8f5p8xy217f"))))
    (build-system julia-build-system)
    (home-page "https://fluxml.ai/MacroTools.jl")
    (synopsis "Tools for working with Julia code and expressions")
    (description "This library provides tools for working with Julia code and
expressions.  This includes a template-matching system and code-walking tools
that let you do deep transformations of code.")
    (license license:expat)))

(define-public julia-mbedtls
  (package
    (name "julia-mbedtls")
    (version "1.0.3")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaLang/MbedTLS.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0zjzf2r57l24n3k0gcqkvx3izwn5827iv9ak0lqix0aa5967wvfb"))))
    (build-system julia-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (add-before 'install 'disable-network-tests
           ;; Tries to connect to httpbin.org
           (lambda _
             (substitute* "test/runtests.jl"
               (("testhost =") "return #"))
             #t)))))
    (propagated-inputs `(("julia-mbedtls-jll" ,julia-mbedtls-jll)))
    (home-page "https://github.com/JuliaLang/MbedTLS.jl")
    (synopsis "Apache's mbed TLS library wrapper")
    (description "@code{MbedTLS.jl} provides a wrapper around the @code{mbed
TLS} and cryptography C libary for Julia.")
    (license license:expat)))

(define-public julia-mbedtls-jll
  (package
    (name "julia-mbedtls-jll")
    ;; version 2.25.0+0 is not compatible with current mbedtls 2.23.0,
    ;; upgrade this when mbedtls is updated in guix
    (version "2.24.0+1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaBinaryWrappers/MbedTLS_jll.jl")
             (commit (string-append "MbedTLS-v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0kk9dlxdh7yms21npgrdfmjbj8q8ng6kdhrzw3jr2d7rp696kp99"))))
    (build-system julia-build-system)
    (arguments
     '(#:tests? #f                      ; No runtests.jl
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'override-binary-path
           (lambda* (#:key inputs #:allow-other-keys)
             (map
              (lambda (wrapper)
                (substitute* wrapper
                  (("generate_wrapper_header.*")
                   (string-append
                    "generate_wrapper_header(\"MbedTLS\", \""
                    (assoc-ref inputs "mbedtls-apache") "\")\n"))))
              ;; There's a Julia file for each platform, override them all
              (find-files "src/wrappers/" "\\.jl$"))
             #t)))))
    (inputs `(("mbedtls-apache" ,mbedtls-apache)))
    (propagated-inputs `(("julia-jllwrappers" ,julia-jllwrappers)))
    (home-page "https://github.com/JuliaBinaryWrappers/MbedTLS_jll.jl")
    (synopsis "Apache's mbed TLS binary wrappers")
    (description "This Julia module provides @code{mbed TLS} libraries and
wrappers.")
    (license license:expat)))

(define-public julia-nanmath
  (package
    (name "julia-nanmath")
    (version "0.3.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/mlubin/NaNMath.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1hczhz00qj99w63vp627kwk02l2sr2qmzc2rkwwkdwvzy670p25q"))))
    (build-system julia-build-system)
    (home-page "https://github.com/mlubin/NaNMath.jl")
    (synopsis "Implementations of basic math functions")
    (description "Implementations of basic math functions which return
@code{NaN} instead of throwing a @code{DomainError}.")
    (license license:expat)))

(define-public julia-orderedcollections
  (package
    (name "julia-orderedcollections")
    (version "1.3.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaCollections/OrderedCollections.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0sfip1ixghsz91q2s7d62rgzw3gppg42fg6bccxlplqa3hfmbycf"))))
    (build-system julia-build-system)
    (home-page "https://github.com/JuliaCollections/OrderedCollections.jl")
    (synopsis "Associative containers that preserve insertion order")
    (description "This package implements @code{OrderedDicts} and
@code{OrderedSets}, which are similar to containers in base Julia.  However,
during iteration the @code{Ordered*} containers return items in the order in
which they were added to the collection.")
    (license license:expat)))

(define-public julia-offsetarrays
  (package
    (name "julia-offsetarrays")
    (version "1.5.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaArrays/OffsetArrays.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1y3fnssw2hzyghrk6jfcxslab0f8sjkjszh482snfq4k6mkrhy77"))))
    (build-system julia-build-system)
    (propagated-inputs
     `(("julia-adapt" ,julia-adapt)))
    ;; CatIndices depends on OffsetArrays, introducing a recursive dependency
    (arguments '(#:tests? #f))
    (home-page "https://juliaarrays.github.io/OffsetArrays.jl/stable/")
    (synopsis "Fortran-like arrays with arbitrary, zero or negative indices")
    (description "@code{OffsetArrays.jl} provides Julia users with arrays that
have arbitrary indices, similar to those found in some other programming
languages like Fortran.")
    (license license:expat)))

(define-public julia-parsers
  (package
    (name "julia-parsers")
    (version "1.0.15")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaData/Parsers.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "16iffl6l28kspgqch48mhi1s8qhspr3cpqcwsph3rqi72lbfqygx"))))
    (build-system julia-build-system)
    (home-page "https://github.com/JuliaData/Parsers.jl")
    (synopsis "Fast parsing machinery for basic types in Julia")
    (description "@code{Parsers.jl} is a collection of type parsers and
utilities for Julia.")
    (license license:expat)))

(define-public julia-reexport
  (package
    (name "julia-reexport")
    (version "1.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/simonster/Reexport.jl")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1yhhja1zz6dy5f4fd19bdwd6jwgj7q4w3avzgyg1hjhmdl8jrh0s"))))
    (build-system julia-build-system)
    (home-page "https://github.com/simonster/Reexport.jl")
    (synopsis "Re-export modules and symbols")
    (description "This package provides tools to re-export modules and symbols.")
    (license license:expat)))

(define-public julia-requires
  (package
    (name "julia-requires")
    (version "1.1.3")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaPackaging/Requires.jl/")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "03hyfy7c0ma45b0y756j76awi3az2ii4bz4s8cxm3xw9yy1z7b01"))))
    (build-system julia-build-system)
    (inputs                             ;required for test
     `(("julia-example" ,julia-example)))
    (propagated-inputs
     `(("julia-colors" ,julia-colors)))
    (home-page "https://github.com/JuliaPackaging/Requires.jl/")
    (synopsis "Faster package loader")
    (description "This package make loading packages faster, maybe.  It
supports specifying glue code in packages which will load automatically when
another package is loaded, so that explicit dependencies (and long load times)
can be avoided.")
    (license license:expat)))

(define-public julia-staticarrays
  (package
    (name "julia-staticarrays")
    (version "1.0.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaArrays/StaticArrays.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "01z8bcqwpfkp8p1h1r36pr5cc3798y76zkas7g3206pcsdhvlkz1"))))
    (build-system julia-build-system)
    (inputs
     `(("julia-benchmarktools" ,julia-benchmarktools)))
    (home-page "https://github.com/JuliaArrays/StaticArrays.jl")
    (synopsis "Statically sized arrays")
    (description "This package provides a framework for implementing
statically sized arrays in Julia, using the abstract type
@code{StaticArray{Size,T,N} <: AbstractArray{T,N}}.  Subtypes of
@code{StaticArray} will provide fast implementations of common array and
linear algebra operations.")
    (license license:expat)))

(define-public julia-uris
  (package
    (name "julia-uris")
    (version "1.2.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaWeb/URIs.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0fqyagsqks5za7m0czafr34m2xh5501f689k9cn5x3npajdnh2r3"))))
    (build-system julia-build-system)
    (arguments
     '(#:julia-package-name "URIs"      ;required to run tests
       #:phases
       (modify-phases %standard-phases
         (add-before 'check 'change-dir
           ;; Tests must be run from the testdir
           (lambda* (#:key source outputs #:allow-other-keys)
             (let ((out (assoc-ref outputs "out")))
               (chdir
                (string-append out "/share/julia/packages/URIs/test")))
             #t)))))
    ;; required for tests
    (inputs `(("julia-json" ,julia-json)))
    (home-page "https://github.com/JuliaWeb/URIs.jl")
    (synopsis "URI parsing in Julia")
    (description "@code{URIs.jl} is a Julia package that allows parsing and
working with @acronym{URIs,Uniform Resource Identifiers}, as defined in RFC
3986.")
    (license license:expat)))

(define-public julia-unitful
  (package
    (name "julia-unitful")
    (version "1.6.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/PainterQubits/Unitful.jl")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0g5bhlvay9yk11c5dqwbzmb3q7lzj0cq5zchyk39d59fkvvmxvq3"))))
    (build-system julia-build-system)
    (propagated-inputs
     `(("julia-constructionbase" ,julia-constructionbase)))
    (home-page "https://painterqubits.github.io/Unitful.jl/stable/")
    (synopsis "Physical units in Julia")
    (description "This package supports SI units and also many other unit
system.")
    (license license:expat)))
