import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';

class AudioMethods {
  String audioPath = "";

  Future<bool> startRecording(bool isRecording, AudioRecorder audioRecorder,
      AudioPlayer audioPlayer) async {
    try {
      if (await audioRecorder.hasPermission()) {
        await audioRecorder
            .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
        return true;
      } else {
        print("Permissão de gravação de áudio não concedida");
        return false;
      }
    } catch (e) {
      print("Erro ao começar a gravar o áudio: $e");
      return false;
    }
  }

  Future<bool> stopRecording(bool isRecording, AudioRecorder audioRecorder,
      AudioPlayer audioPlayer) async {
    try {
      final path = await audioRecorder.stop();
      audioPath = path!;
      return false;
    } catch (e) {
      print("Erro ao parar o áudio: $e");
      return true;
    }
  }

  Future<void> playRecording(bool isRecording, AudioRecorder audioRecorder,
      AudioPlayer audioPlayer) async {
    try {
      Source urlSource = UrlSource(audioPath);
      await audioPlayer.play(urlSource);
    } catch (e) {
      print("Erro ao rodar o seu audio $e");
    }
  }
}
