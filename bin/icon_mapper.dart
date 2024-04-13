import 'dart:convert';
import 'dart:io';

void main() async {
  final input = File('asset/remix_icons.txt');
  final output = File('asset/remix_icon_map.txt');

  await output.writeAsString('final filledIconMap = { \n');

  final outputWriter = output.openWrite(mode: FileMode.append);

  await utf8.decoder
      .bind(input.openRead())
      .transform(const LineSplitter())
      .forEach((line) {
    if (!line.contains('IconData')) {
      return;
    }

    final words = line.split(' ');
    outputWriter.writeln("'${words[5]}':RemixIcons.${words[5]},");
  });

  await outputWriter.close();
  await output.writeAsString('};', mode: FileMode.append);
}
