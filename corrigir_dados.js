const fs = require("fs/promises"); // Usando fs.promises para evitar callback hell

const caminhoArquivos = [
  "./broken_database_1.json",
  "./broken_database_2.json",
];
const arquivos = [];

async function lerArquivos(arquivos) {
  for (const arquivo of arquivos) {
    try {
      const dados = await fs.readFile(arquivo, "utf8");
      const dadosCorrompidos = JSON.parse(dados);
      corrigirDados(dadosCorrompidos);
    } catch (erro) {
      console.error("Erro ao ler o arquivo:", erro);
    }
  }
}

function corrigirDados(dados) {
  const newData = dados.map((item) => {
    if (item.vendas) {
      item.vendas = Number(item.vendas);
    }
    const oldItem = JSON.stringify(item);
    const itemFormatado = oldItem.replace(/æ/g, "a").replace(/ø/g, "o");
    return JSON.parse(itemFormatado);
  });

  const arquivo = JSON.stringify(newData);
  arquivos.push(arquivo);
}

async function salvarArquivos(arquivos) {
  for (let index = 0; index < arquivos.length; index++) {
    const arquivo = arquivos[index];
    const caminhoArquivo = `./arquivos_corrigidos/database_${index}.json`;

    try {
      await fs.writeFile(caminhoArquivo, arquivo, "utf8");
      console.log(`Arquivo JSON ${index} exportado com sucesso!`);
    } catch (erro) {
      console.error("Erro ao exportar o arquivo JSON:", erro);
    }
  }
}

async function corrigirBanco() {
  try {
    await lerArquivos(caminhoArquivos);
    await salvarArquivos(arquivos);
  } catch (error) {
    console.error(error);
  }
}

corrigirBanco();
