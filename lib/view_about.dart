import 'package:flutter/material.dart';
import 'package:mcinfo_app/shared.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMainView extends StatelessWidget {
  const AboutMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text.rich(
              TextSpan(children: <InlineSpan>[
                TextSpan(
                    text: "MCInfo App\n\n",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24)),
                TextSpan(
                    text: "A Minecraft Information App\n",
                    style: TextStyle(fontSize: 16)),
                TextSpan(
                    text: "Developed by exoad",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: "\n\nBuild version $mcinfo_build_version",
                    style: TextStyle(
                        fontSize: 12, fontStyle: FontStyle.italic))
              ]),
              textAlign: TextAlign.start,
            ),
            const Divider(),
            Wrap(runSpacing: 8, spacing: 8, children: <Widget>[
              TextButton(
                  onPressed: () async => await launchUrl(
                      Uri.parse("https://github.com/exoad/mcinfo")),
                  child: const Text("Source Code")),
              TextButton(
                  onPressed: () async => await launchUrl(Uri.parse(
                      "https://github.com/exoad/mcinfo/issues/new")),
                  child: const Text("Submit bug report")),
              TextButton(
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute<Widget>(
                          builder: (BuildContext context) => Scaffold(
                                body: const SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text("""
Copyright (c) 2024, Jack Meng (exoad) All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
   1. Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
   2. Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in
      the documentation and/or other materials provided with the
      distribution.
   3. All advertising materials mentioning features or use of this software
      must display the following acknowledgment: This product includes
      software developed by Jack Meng (exoad).
   4. Neither the name of Jack Meng (exoad) nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY JACK MENG (EXOAD) AS IS AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS FOR A PARTICULAR PURPOSE IS DISCLAIMED. IN NO EVENT SHALL
JACK MENG (EXOAD) BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
                                                            """,
                                        style: TextStyle(
                                            fontFamily: "Monospace",
                                            fontSize: 14)),
                                  ),
                                ),
                                appBar: AppBar(
                                    title: const Text(
                                        "Source Code license")),
                              ))),
                  child: const Text("License")),
              TextButton(
                  onPressed: () => showLicensePage(
                      context: context,
                      applicationName: "MCInfo App",
                      applicationVersion:
                          mcinfo_build_version.toString()),
                  child: const Text("Third Party Licenses"))
            ]),
          ],
        ),
      ),
    );
  }
}
