import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manger/speech_to_text/speech_to_text_cubit.dart';

class SpeechToTextBlocBuilder extends StatelessWidget {
  const SpeechToTextBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SpeechToTextCubit, SpeechToTextState>(
          builder: (context, state) {
            if (state is SpeechListening || state is SpeechRecognized) {
              return Text(
                (state as dynamic).recognizedWords,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              );
            } else {
              return Text(
                "",
              );
            }
          },
        ),
        SizedBox(
          height: 30,
        ),
        BlocBuilder<SpeechToTextCubit, SpeechToTextState>(
          builder: (context, state) {
            return IconButton(
                onPressed: state is SpeechListening
                    ? context.read<SpeechToTextCubit>().stopListening
                    : context.read<SpeechToTextCubit>().startListening,
                icon: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        Color(0xff5ea0fe),
                        Color(0xffa8e2ed),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  child: Icon(
                    Icons.mic,
                    size: 80,
                    color: Colors
                        .white, // The color here is a base color that will be masked by the gradient
                  ),
                ));
          },
        )
      ],
    );
  }
}
