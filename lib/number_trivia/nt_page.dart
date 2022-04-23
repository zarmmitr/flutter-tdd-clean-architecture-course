import 'pl/nt_pl.dart' show Empty, Error, Loaded, Loading, NumberTriviaBloc, NumberTriviaState;
import 'ui/nt_ui.dart' show LoadingBox, MessageBox, TriviaControl, TriviaBox;
import 'package:flutter/material.dart' show AppBar, BuildContext, Center, Column, EdgeInsets, Padding, Scaffold, SingleChildScrollView, SizedBox, StatelessWidget, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;

import 'package:z_/injection_container.dart' show sl;

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageBox(
                      message: 'Start searching!',
                    );
                  } else if (state is Loading) {
                    return LoadingBox();
                  } else if (state is Loaded) {
                    return TriviaBox(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageBox(
                      message: state.message,
                    );
                  }
                  return LoadingBox(); // error?
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              TriviaControl()
            ],
          ),
        ),
      ),
    );
  }
}
