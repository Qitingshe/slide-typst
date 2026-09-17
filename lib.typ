// lib.typ - 共享工具模块
// 供 main.typ 和 chapters/*.typ 共同使用

#import "@preview/touying:0.7.4": *
#import themes.university: *
#import "@preview/cetz:0.4.2"
#import "@preview/numbly:0.1.0": numbly

// ==== Framasoft 配色 ====
#let framableu = rgb("#0C5B7A")
#let framableulight = rgb("#1290B0")
#let framavert = rgb("#8E9C48")
#let framavertlight = rgb("#E3EBC7")
#let framarouge = rgb("#CC2D18")
#let framarougelight = rgb("#F9BDBB")
#let framaviolet = rgb("#6A5687")
#let framavioletlight = rgb("#D3C5E8")
#let framaorange = rgb("#EB7239")
#let framaorangelight = rgb("#EBD1C5")
#let framajaune = rgb("#C4A81B")
#let framajaunelight = rgb("#FFEBB5")
#let framamarron = rgb("#A1887F")
#let framamarronlight = rgb("#D7CCC8")
#let framagris = rgb("#616161")
#let framagrislight = rgb("#F5F5F5")

// ==== 强调文本（对应 \emph，Framaorange 加粗）====
#let frameEmph(body) = text(fill: framaorange, weight: "bold", body)

// ==== 彩色盒子（对应 \boiteXXX）====
#let _boite(content, color: framableu) = {
  block(
    inset: 10pt,
    radius: 3pt,
    fill: color.lighten(85%),
    stroke: (paint: color, thickness: 1pt),
  )[#content]
}

#let boitebleue(content) = _boite(content, color: framableu)
#let boiteverte(content) = _boite(content, color: framavert)
#let boiterouge(content) = _boite(content, color: framarouge)
#let boiteorange(content) = _boite(content, color: framaorange)
#let boiteviolette(content) = _boite(content, color: framaviolet)
#let boitejaune(content) = _boite(content, color: framajaune)
#let boitemarron(content) = _boite(content, color: framamarron)
#let boitegrise(content) = _boite(content, color: framagris)

// ==== 主题配置 ====
#let slide-theme = university-theme.with(
  aspect-ratio: "16-9",
  config-colors(
    primary: framableu,
    primary-light: framableulight,
    secondary: framavert,
    secondary-light: framavertlight,
    tertiary: framaorange,
    tertiary-light: framaorangelight,
    neutral: framagris,
    neutral-lightest: rgb("#ffffff"),
    neutral-darkest: rgb("#000000"),
  ),
  config-info(
    title: [Title],
    subtitle: none,
    author: [QITINGSHE],
    date: datetime.today(),
    institution: [USTC],
    contact: none,
    logo: none,
  ),
)

// ==== CeTZ 与 Touying 的动画绑定 ====
#let cetz-canvas = touying-reducer.with(
  reduce: cetz.canvas,
  cover: cetz.draw.hide.with(bounds: true),
)