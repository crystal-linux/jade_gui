class Desktop {
  final String name;
  final String displayManager;
  final List<String> packages;
  final String imageurl;

  const Desktop({
    this.name = "",
    this.displayManager = "",
    this.packages = const [""],
    this.imageurl = 'assets/jade_logo.png',
  });
}
