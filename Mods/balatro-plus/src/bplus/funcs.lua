function G.FUNCS.bplus_mod_config_replace_splash_logo(args)
  BPlus.config.replace_splash_logo = args.to_key == 1
  BPlus.update_splash_logo()
  G:save_settings()
end
