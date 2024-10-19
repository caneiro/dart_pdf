/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';
// import 'dart:math';
import 'dart:typed_data';

// import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

import '../data.dart';

Future<Uint8List> generateLOTO(PdfPageFormat format, CustomData data) async {
  final pdf = pw.Document(title: 'My Résumé', author: 'David PHAM-VAN');

  // Adicionar uma página ao PDF
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return [
          // Cabeçalho principal
          pw.Text('Procedimento Lockout/Tagout',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 20),

          // Seção de Informações
          _buildLockoutInfo(),

          pw.SizedBox(height: 20),

          // Processo de Solicitação de Bloqueio com caixa ao redor
          _buildSectionTitle('Processo de Solicitação de Bloqueio', PdfColors.red),
          _buildLockoutRequestProcess(),

          pw.SizedBox(height: 20),

          // Etapas de Bloqueio com caixa ao redor
          _buildSectionTitle('Etapas de Bloqueio', PdfColors.blue),
          _buildLockoutSteps(),

          pw.SizedBox(height: 20),

          // Etapas de Remoção de Bloqueio com caixa ao redor
          _buildSectionTitle('Etapas de Remoção do Bloqueio', PdfColors.orange),
          _buildLockRemovalSteps(),

          pw.SizedBox(height: 20),

          // Procedimento Final de Remoção com caixa ao redor
          _buildSectionTitle('Procedimento Final de Remoção de Bloqueio', PdfColors.red),
          _buildFinalLockRemoval(),
        ];
      },
    ),
  );

  // Retorna o PDF gerado como bytes
  return pdf.save();
}

// Função que cria o título da seção com margem, cor de fundo e borda
pw.Widget _buildSectionTitle(String title, PdfColor backgroundColor) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 10, top: 10),
    padding: const pw.EdgeInsets.all(8),
    decoration: pw.BoxDecoration(
      color: backgroundColor,
      borderRadius: pw.BorderRadius.circular(4),
      border: pw.Border.all(
        color: PdfColors.black,
        width: 2,
      ),
    ),
    child: pw.Text(
      title,
      style: pw.TextStyle(
        fontSize: 16,
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.white, // Cor do texto em branco
      ),
    ),
  );
}

// Função que cria a seção de informações de bloqueio
pw.Widget _buildLockoutInfo() {
  return pw.Container(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Pontos de Bloqueio: VCR-1', style: pw.TextStyle(fontSize: 16)),
        pw.Text('Site: REC3', style: pw.TextStyle(fontSize: 16)),
        pw.Text('Localização: 4º Pav - Pick Mood', style: pw.TextStyle(fontSize: 16)),
        pw.Text('Data: 21/04/2024', style: pw.TextStyle(fontSize: 16)),
        pw.Text('Equipamento: Elevador de Carga', style: pw.TextStyle(fontSize: 16)),
        pw.SizedBox(height: 10),
        pw.Text(
          'Objetivo: Este procedimento estabelece os requisitos mínimos para o bloqueio de energias presentes sempre que houver manutenção ou reparo em máquinas ou equipamentos. Ele deve ser usado para garantir que a máquina ou equipamento seja inativo, isolado de todas as fontes de energia potencialmente perigosas e bloqueadas antes que os funcionários executem qualquer serviço ou manutenção em que as energizações inesperadas ou partida da máquina ou equipamento ou liberação de energia armazenada possam causar ferimentos.',
          style: pw.TextStyle(fontSize: 12),
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          'Cumprimento deste programa: Os funcionários autorizados são obrigados a realizar o bloqueio de acordo com este procedimento. Falha ao seguir o trabalho e procedimentos padrão da LOTO resultarão em ação disciplinar, incluindo demissão. Todos os funcionários, ao observarem uma máquina ou equipamento bloqueado para realizar reparos ou manutenção, não devem tentar ligar, energizar ou usar a máquina ou equipamento.',
          style: pw.TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}

// Processo de Solicitação de Bloqueio
pw.Widget _buildLockoutRequestProcess() {
  return pw.Container(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Bullet(text: 'NOTIFIQUE o pessoal afetado pelo equipamento que deve ser bloqueado.'),
        pw.Bullet(text: 'DESLIGUE o equipamento com os procedimentos normais de desligamento.'),
        pw.Bullet(text: 'BLOQUEIO: Desconecte e bloqueie todas as fontes de energia e libere qualquer energia armazenada, se possível.'),
        pw.Bullet(text: 'ETIQUETA: Certifique-se de que a etiqueta esteja claramente marcada com as informações necessárias.'),
        pw.Bullet(text: 'TESTE: Verifique se todas as fontes de energia estão isoladas testando o equipamento.'),
        pw.Bullet(text: 'RETORNE os controles para a posição desligada ou neutra.'),
      ],
    ),
  );
}

// Etapas de Bloqueio
pw.Widget _buildLockoutSteps() {
  return pw.Container(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Elétrica - 380 Volts', style: pw.TextStyle(fontSize: 16)),
        pw.Text('Localização: QF-ELEVADORES', style: pw.TextStyle(fontSize: 12)),
        pw.Text('Procedimento: Abra o quadro elétrico e localize o disjuntor. Desligue o disjuntor colocando na posição off. Insira o dispositivo de bloqueio universal.', style: pw.TextStyle(fontSize: 12)),
        pw.Text('Verificação: Verifique a ausência de tensão com multímetro ou detector de tensão antes de iniciar a atividade.', style: pw.TextStyle(fontSize: 12)),
      ],
    ),
  );
}

// Etapas de Remoção de Bloqueio
pw.Widget _buildLockRemovalSteps() {
  return pw.Container(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Bullet(text: 'LIMPE a máquina de ferramentas e quaisquer outros itens.'),
        pw.Bullet(text: 'NOTIFIQUE todos os funcionários afetados de que o equipamento está voltando ao serviço.'),
        pw.Bullet(text: 'REMOVA a trava de segurança e restaure a energia da fonte de energia.'),
        pw.Bullet(text: 'REALIZE testes/solução de problemas.'),
        pw.Bullet(text: 'RETORNE ao estado de energia zero após a conclusão do teste/solução de problemas.'),
      ],
    ),
  );
}

// Procedimento Final de Remoção de Bloqueio
pw.Widget _buildFinalLockRemoval() {
  return pw.Container(
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Bullet(text: 'INSPECIONE a área de trabalho: remova todos os itens não essenciais e recoloque todas as proteções.'),
        pw.Bullet(text: 'VERIFIQUE a segurança do funcionário: verifique se todos os funcionários afetados nas proximidades da máquina estão em uma área/posição segura.'),
        pw.Bullet(text: 'NOTIFIQUE os funcionários afetados de que o bloqueio será removido.'),
        pw.Bullet(text: 'REMOVA cada cadeado/etiqueta devendo ser removido pelo indivíduo que o aplicou.'),
        pw.Bullet(text: 'NOTIFIQUE todos os funcionários autorizados e afetados de que os dispositivos de bloqueio/sinalização foram removidos.'),
      ],
    ),
  );
}