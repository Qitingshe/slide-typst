// chapters/algorithms.typ
#import "../lib.typ": *

== Gaussian Random Fields

=== The model in graph representation

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    // 网格表示 (对应 LaTeX 左侧 tikzpicture)
    #cetz.canvas({
      import cetz.draw: *

      // 网格与坐标轴
      grid((0, 0), (4, 4), step: 1, stroke: gray.lighten(80%))
      line((0, 0), (4.2, 0), mark: (end: "stealth"))
      line((0, 0), (0, 4.2), mark: (end: "stealth"))
      content((4.3, 0), [$x$])
      content((0, 4.3), [$y$])

      // 占据的栅格单元 m1-m4
      rect((1, 1), (2, 2), fill: framarouge.transparentize(50%), stroke: none)
      rect((1, 2), (2, 3), fill: framarouge.transparentize(50%), stroke: none)
      rect((2, 2), (3, 3), fill: framarouge.transparentize(50%), stroke: none)
      rect((2, 1), (3, 2), fill: framarouge.transparentize(50%), stroke: none)

      content((1.5, 1.4), [*m1*])
      content((1.5, 2.4), [*m2*])
      content((2.5, 2.4), [*m3*])
      content((2.5, 1.4), [*m4*])
    })
  ],
  [
    // 概率图模型：时间 T-1 → T 的状态演化
    #cetz.canvas({
      import cetz.draw: *

      let r = 0.18
      let m1 = (1, 3.5)
      let m2 = (2.2, 3.5)
      let m4 = (1, 4.5)
      let m3 = (2.2, 4.5)

      // 标签渲染: L(x, y, label)
      let L = (x, y, label, dx: -0.35) => content((x + dx, y), label, size: 0.8em)

      // ==== 时间 T-1 层 ====
      circle(m1, radius: r, fill: framarouge); L(m1.at(0), m1.at(1), [*m1*])
      circle(m2, radius: r, fill: framarouge); L(m2.at(0), m2.at(1), [*m2*])
      circle(m4, radius: r, fill: framarouge); L(m4.at(0), m4.at(1), [*m4*])
      circle(m3, radius: r, fill: framarouge); L(m3.at(0), m3.at(1), [*m3*])
      line((m1.at(0) + 0.2, m1.at(1)), (m2.at(0) - 0.2, m2.at(1)))
      line((m4.at(0) + 0.2, m4.at(1)), (m3.at(0) - 0.2, m3.at(1)))
      line((m1.at(0), m1.at(1) + 0.2), (m4.at(0), m4.at(1) - 0.2))
      line((m2.at(0), m2.at(1) + 0.2), (m3.at(0), m3.at(1) - 0.2))
      content((0.4, 4.6), [time $T-1$], size: 0.7em)

      // ==== 时间 T 层 ====
      let t1 = (1, 1.2)
      let t2 = (2.2, 1.2)
      let t4 = (1, 2.2)
      let t3 = (2.2, 2.2)
      circle(t1, radius: r, fill: framarouge); L(t1.at(0), t1.at(1), [*m1*])
      circle(t2, radius: r, fill: framarouge); L(t2.at(0), t2.at(1), [*m2*])
      circle(t4, radius: r, fill: framarouge); L(t4.at(0), t4.at(1), [*m4*])
      circle(t3, radius: r, fill: framarouge); L(t3.at(0), t3.at(1), [*m3*])
      line((t1.at(0) + 0.2, t1.at(1)), (t2.at(0) - 0.2, t2.at(1)))
      line((t4.at(0) + 0.2, t4.at(1)), (t3.at(0) - 0.2, t3.at(1)))
      line((t1.at(0), t1.at(1) + 0.2), (t4.at(0), t4.at(1) - 0.2))
      line((t2.at(0), t2.at(1) + 0.2), (t3.at(0), t3.at(1) - 0.2))

      // 隐变量 z
      let z1 = (3.6, 1.2)
      let z2 = (3.6, 2.2)
      circle(z1, radius: r, fill: framableulight)
      circle(z2, radius: r, fill: framableulight)
      L(z1.at(0), z1.at(1), [*z1*], dx: 0.35)
      L(z2.at(0), z2.at(1), [*z2*], dx: 0.35)

      // 时间演化边 (T-1 → T)
      for x in (1, 2.2) {
        line((x, 3.3), (x, 2.4), mark: (end: "stealth"), stroke: gray)
      }
      // 观测边 m → z
      line((t1.at(0) + 0.2, t1.at(1)), (z1.at(0) - 0.2, z1.at(1)), mark: (end: "stealth"))
      line((t4.at(0) + 0.2, t4.at(1)), (z2.at(0) - 0.2, z2.at(1)), mark: (end: "stealth"))

      content((0.7, -0.3), [time $T$], size: 0.7em)
    })
  ],
)

=== The model in the probability representation

According to the Hammersley-Clifford theorem [Clifford, 1990], the joint probability
distribution $p(m_t, z_t, m_(t-1))$ can be factored as the product of the potential
functions and divided by the normalize constant $Z$.

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #cetz.canvas({
      import cetz.draw: *

      let r = 0.18
      let m1 = (1, 3.5)
      let m2 = (2.2, 3.5)
      let m4 = (1, 4.5)
      let m3 = (2.2, 4.5)
      let t1 = (1, 1.2)
      let t2 = (2.2, 1.2)
      let t4 = (1, 2.2)
      let t3 = (2.2, 2.2)
      let z1 = (3.6, 1.2)
      let z2 = (3.6, 2.2)
      let L = (x, y, label, dx: -0.35) => content((x + dx, y), label, size: 0.8em)

      // 时间 T-1 层
      for (p, l) in ((m1, [*m1*]), (m2, [*m2*]), (m4, [*m4*]), (m3, [*m3*])) {
        circle(p, radius: r, fill: framarouge); L(p.at(0), p.at(1), l)
      }
      line((m1.at(0) + 0.2, m1.at(1)), (m2.at(0) - 0.2, m2.at(1)))
      line((m4.at(0) + 0.2, m4.at(1)), (m3.at(0) - 0.2, m3.at(1)))
      line((m1.at(0), m1.at(1) + 0.2), (m4.at(0), m4.at(1) - 0.2))
      line((m2.at(0), m2.at(1) + 0.2), (m3.at(0), m3.at(1) - 0.2))

      // 时间 T 层
      for (p, l) in ((t1, [*m1*]), (t2, [*m2*]), (t4, [*m4*]), (t3, [*m3*])) {
        circle(p, radius: r, fill: framarouge); L(p.at(0), p.at(1), l)
      }
      line((t1.at(0) + 0.2, t1.at(1)), (t2.at(0) - 0.2, t2.at(1)))
      line((t4.at(0) + 0.2, t4.at(1)), (t3.at(0) - 0.2, t3.at(1)))
      line((t1.at(0), t1.at(1) + 0.2), (t4.at(0), t4.at(1) - 0.2))
      line((t2.at(0), t2.at(1) + 0.2), (t3.at(0), t3.at(1) - 0.2))

      // 隐变量 z
      circle(z1, radius: r, fill: framableulight); L(z1.at(0), z1.at(1), [*z1*], dx: 0.35)
      circle(z2, radius: r, fill: framableulight); L(z2.at(0), z2.at(1), [*z2*], dx: 0.35)

      // 演化边
      for x in (1, 2.2) {
        line((x, 3.3), (x, 2.4), mark: (end: "stealth"), stroke: gray)
      }
      // 观测边
      line((t1.at(0) + 0.2, t1.at(1)), (z1.at(0) - 0.2, z1.at(1)), mark: (end: "stealth"))
      line((t4.at(0) + 0.2, t4.at(1)), (z2.at(0) - 0.2, z2.at(1)), mark: (end: "stealth"))
    })
  ],
  [
    $
      p(m_t, z_t, m_(t-1)) = 1/Z p(m_(t-1)) \
        product_(i=1)^N p(m_(i t) | m_(i(t-1))) \
        product_(i j)^M p(m_(i t) | m_(j t)) \
        product_(i subset.eq N) p(z_i | m_(i t))
    $
  ],
)

== Detail of the model

Since except $m_t$ all other variables are known, the posterior distribution is

$
  p(m_t | z_t, m_(t-1)) prop p(m_(t-1)) \
    product_(i=1)^N p(m_(i t) | m_(i(t-1))) \
    product_(i j)^M p(m_(i t) - m_(j t)) \
    product_(i subset.eq N) p(z_i | m_(i t))
$

- time variation: $p(m_(i t) | m_(i(t-1))) = "N"(m_(i(t-1)), sigma_t^2)$
- obstacle consideration: $p(m_(i t) - m_(j t)) = "N"(0, sigma_n^2 / (1 - p(o_(i j)))^2)$, where
  $p(o_(i j))$ close to 1 means one of the cells is an obstacle.
- sensor uncertainty: $p(z_i | m_(i t)) = "N"(m_(i t), sigma_s^2)$

== Computation

Computation goes here…