enum Code {
  add(10000),
  delete(20000),
  update(30000),
  blog(1000),
  photo(2000),
  story(3000),
  video(4000),
  choose(100),
  crop(200),
  translate(300);

  final int value;

  const Code(this.value);
}
