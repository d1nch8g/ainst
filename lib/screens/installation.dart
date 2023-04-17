import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/constants.dart';
import 'package:installer/utils/install.dart';
import 'package:installer/utils/syscall.dart';

class InstallationContent extends StatefulWidget {
  const InstallationContent({super.key});

  @override
  State<InstallationContent> createState() => _InstallationContentState();
}

class _InstallationContentState extends State<InstallationContent> {
  Widget placeholder = Container();

  runInstall() async {
    setState(() {
      placeholder = Column(
        key: UniqueKey(),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingCircle(
            color: Colors.white,
            size: MediaQuery.of(context).size.height * 0.36,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: const Text(
              "Система устанавливается...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: const Text(
              "Это произойдет в течении нескольких минут, чилим",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: const Text(
              "Пока можно настроить вкладки в браузере или войти в телеграм, пользовательская папка будет перенесена в установленную систему",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 88),
        ],
      );
    });
    await writeConfigurations();
    var rez = await installSystem();
    if (rez != "ok") {
      setState(() {
        placeholder = SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.85,
          child: SingleChildScrollView(
            child: Text(
              rez,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      });
      return;
    }
    setState(() {
      placeholder = Column(
        key: UniqueKey(),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/restart.png",
            height: MediaQuery.of(context).size.height * 0.36,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: const Text(
              "Готово",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: const Text(
              "Теперь можно перезагрузить и зайти в систему",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          FmnxTextButton(
            text: "Перезагрузка",
            onPressed: () {
              syscall("reboot ''");
            },
          ),
        ],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 120), () {
      setState(() {
        placeholder = Column(
          key: UniqueKey(),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/system.png",
              height: MediaQuery.of(context).size.height * 0.36,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const Text(
                "Начать установку",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const Text(
                "Установка обычно не занимает более 15 минут, зависит от скорости подключения",
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            FmnxTextButton(
              text: "Запуск",
              onPressed: () {
                runInstall();
              },
            ),
          ],
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 644),
          child: placeholder,
        ),
      ),
    );
  }
}
