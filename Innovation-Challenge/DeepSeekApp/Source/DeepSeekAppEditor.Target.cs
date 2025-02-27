// Fill out your copyright notice in the Description page of Project Settings.

using UnrealBuildTool;
using System.Collections.Generic;

public class DeepSeekAppEditorTarget : TargetRules
{
	public DeepSeekAppEditorTarget(TargetInfo Target) : base(Target)
	{
		Type = TargetType.Editor;
		DefaultBuildSettings = BuildSettingsVersion.V5;
		bOverrideBuildEnvironment = true;

		ExtraModuleNames.AddRange( new string[] { "DeepSeekApp" } );
	}
}
