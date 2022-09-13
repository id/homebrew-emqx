class Emqx < Formula
  desc "The Most Scalable MQTT Broker for IoT"
  homepage "emqx.io"
  version "5.0.7"
  url "https://github.com/emqx/emqx/archive/refs/tags/v#{version}.tar.gz"
  sha256 "a437ee2b469233aaa27e35506ffdef51175e04bbc070bb0d33d6e4cc0d1fb65d"
  license "Apache License 2.0"
  head "https://github.com/emqx/emqx.git", branch: "master"

  def dashboard_version
    "1.0.8"
  end

  depends_on "emqx/emqx-erlang/emqx-erlang" => :build
  depends_on "autoconf"  => :build
  depends_on "automake"  => :build
  depends_on "cmake"     => :build
  depends_on "coreutils" => :build
  depends_on "curl"      => :build
  depends_on "freetds"   => :build
  depends_on "libtool"   => :build
  depends_on "unzip"     => :build
  depends_on "zip"       => :build
  depends_on "openssl@1.1"

  def install
    ENV["PKG_VSN"] = "#{version}"
    ENV["PROFILE"] = "emqx"
    ENV["EMQX_DASHBOARD_VERSION"] = "v#{dashboard_version}"
    system "make", "ensure-rebar3"
    system "./build", "emqx", "rel"
    system "mkdir", "-p", "#{prefix}"
    system "rsync", "-av", "_build/emqx/rel/emqx/", "#{prefix}/"
  end

  def caveats
    <<~EOS
      Start/stop emqx daemon:

         #{HOMEBREW_PREFIX}/bin/emqx start
         #{HOMEBREW_PREFIX}/bin/emqx stop

      More commands

         #{HOMEBREW_PREFIX}/bin/emqx help
    EOS
  end
end
