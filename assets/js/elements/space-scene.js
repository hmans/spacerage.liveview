import * as THREE from "three"
import { ThreeScene } from "three-elements"
import { EffectComposer } from "three/examples/jsm/postprocessing/EffectComposer"
import { ShaderPass } from "three/examples/jsm/postprocessing/ShaderPass"
import { SSAARenderPass } from "three/examples/jsm/postprocessing/SSAARenderPass"
import { UnrealBloomPass } from "three/examples/jsm/postprocessing/UnrealBloomPass"
import { VignetteShader } from "three/examples/jsm/shaders/VignetteShader"

class SpaceScene extends ThreeScene {
  mountedCallback() {
    super.mountedCallback()

    const scene = this.object

    /* Load skybox */
    const loader = new THREE.CubeTextureLoader()
    const texture = loader.load([
      "/assets/textures/skybox/right.png",
      "/assets/textures/skybox/left.png",
      "/assets/textures/skybox/top.png",
      "/assets/textures/skybox/bottom.png",
      "/assets/textures/skybox/front.png",
      "/assets/textures/skybox/back.png"
    ])
    scene.background = texture

    this.setupComposer()
  }

  setupComposer() {
    const { game, camera } = this
    const renderer = game.renderer
    const width = game.clientWidth
    const height = game.clientHeight
    const scene = this.object

    this.composer = new EffectComposer(renderer)

    /* Add AA render pass */
    const ssaaPass = new SSAARenderPass(scene, camera, "white", 0)
    ssaaPass.unbiased = false
    ssaaPass.sampleLevel = 2
    this.composer.addPass(ssaaPass)

    /* Add bloom pass */
    const bloom = new UnrealBloomPass(new THREE.Vector2(width, height), 5, 1, 0.6)
    this.composer.addPass(bloom)

    /* Vignette */
    const vignette = new ShaderPass(VignetteShader)
    this.composer.addPass(vignette)
  }

  render() {
    this.composer && this.composer.render()
  }
}

customElements.define("space-scene", SpaceScene)
